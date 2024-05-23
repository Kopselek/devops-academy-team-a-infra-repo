SECONDS=0
terraform destroy -auto-approve
duration=$SECONDS
echo "DESTRUCTION TIME: $(($duration / 60)) MINUTES AND $(($duration % 60)) SECONDS."