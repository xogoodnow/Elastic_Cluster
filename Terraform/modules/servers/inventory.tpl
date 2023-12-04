all:
    children:
        helsinki:
            hosts:
            %{ for index, ip in elastic_ips }
                elastic-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'elastic'
                    init_cluster: ${index == 0 ? "'true'" : "'false'"}
            %{ endfor }

            %{ for index, ip in monitoring_ips }
                monitoring-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'monitoring'
                    init_cluster: 'false'
            %{ endfor }