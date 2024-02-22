all:
    children:
        elasticsearch:
            hosts:
            %{ for index, ip in elastic_ips }
                elastic-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'elastic'
                    init_cluster: ${index == 0 ? "'true'" : "'false'"}
            %{ endfor }
        monitoring:
            hosts:
            %{ for index, ip in monitoring_ips }
                monitoring-${index}:
                    ansible_host: ${ip}
                    ansible_user: root
                    mode: 'monitoring'
                    init_cluster: 'false'
            %{ endfor }