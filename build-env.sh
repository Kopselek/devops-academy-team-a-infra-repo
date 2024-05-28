terraform init -upgrade
echo "APPLYING NEW TERRAFORM DEPLOYMENT"
terraform apply -auto-approve
duration=$SECONDS
echo "DEPLOYMENT TIME: $(($duration / 60)) MINUTES AND $(($duration % 60)) SECONDS."