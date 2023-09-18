1. Go to /OM/
2. change ID for your account ID in variables .tf
3.  go to /OM/Alerts/Infra/
4. change ID for your account ID in variables .tf
5. if you use s3 for your terraform state, you need make the changes in the provider files
6. You need change the querys inside the tf  exa:
    
    change the xxxx for your entity name or add the tag in the query, ex: like tag.ec2.services = 'om'

    SELECT average(host.cpuPercent) AS 'CPU used %' FROM Metric WHERE `entity.name` like 'xxxx%' facet entity.name

     You need to change in cpu.ft - memory.tf and provider.tf


To run your alerts 

   1. Go to required folder.
   2. terraform init
   3. terraform plan and enter api_key     
   4. terraform apply --auto-approve and enter api_key
