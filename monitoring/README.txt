To activate monitoring you need 2 machines.
- machine that will host prometheus and grafana
- target machine

Move files from ./scripts/services to target machine and execute the bash script
Make sure that node exporter is working by accessing it on "localhost:9100"

To deploy monitoring
Go to your machine that will host prometheus and grafana.

adjust prometheus target config in ./prometheus/config/prometheus.yml
by adding tartgets proper IP
After that you can launch docker-compose on this machine

check if prometheus and grafana are working

prometheus: localhost:9090

grafana: localhost:3000

default credentials for grafana are:
login:    admin
password: admin


Prerequisites:

 - Remember that ports have to be unlocked
 - you need docker installed on machine that will host prometheus and grafana

Export:
During export, enable the "Export for sharing externally" option to remove installation-specific references, making it easier to import the dashboard into another Grafana setup. This ensures the dashboard is universally compatible, enhancing flexibility in monitoring configurations across different environments.

New machine:
If you create a new machine, remember about changing ip's in dashboard-provider.json. Don't change the port in this file.
