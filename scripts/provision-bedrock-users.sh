#!/usr/bin/env bash
# [Staff only] Create time-boxed IAM users for the training and emit
# per-pair credential snippets under out/ (gitignored).
# Usage:   AWS_PROFILE=<admin-profile> scripts/provision-bedrock-users.sh <pairs>
# Cleanup: scripts/cleanup-bedrock-users.sh <pairs>  (run after the training, always)
set -euo pipefail
PAIRS="${1:?usage: provision-bedrock-users.sh <pairs>}"
OUT="$(cd "$(dirname "$0")/.." && pwd)/out"
mkdir -p "$OUT"

POLICY='{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": ["bedrock:InvokeModel", "bedrock:InvokeModelWithResponseStream"],
    "Resource": "*"
  }]
}'

for i in $(seq 1 "$PAIRS"); do
  U="genai-training-pair$(printf '%02d' "$i")"
  echo "== $U"
  aws iam create-user --user-name "$U" --tags Key=purpose,Value=genai-training >/dev/null
  aws iam put-user-policy --user-name "$U" --policy-name bedrock-invoke-only --policy-document "$POLICY"
  read -r KEY SECRET < <(aws iam create-access-key --user-name "$U" \
    --query 'AccessKey.[AccessKeyId,SecretAccessKey]' --output text)

  {
    echo "# Append the 3 lines below to ~/.aws/credentials (create the file if absent)."
    echo "[genai-training]"
    echo "aws_access_key_id = $KEY"
    echo "aws_secret_access_key = $SECRET"
  } > "$OUT/$U-credentials.txt"
done
echo "Wrote credential snippets to out/. Distribute one file per pair."
echo "After the training, ALWAYS run: scripts/cleanup-bedrock-users.sh $PAIRS"
