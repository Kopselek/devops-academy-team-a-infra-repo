SECONDS=0
terraform destroy -auto-approve
duration=$SECONDS
rm -rf .terraform .terraform.lock.hcl inventory-linux terraform.tfstate terraform.tfstate.backup
echo "DESTRUCTION TIME: $(($duration / 60)) MINUTES AND $(($duration % 60)) SECONDS."