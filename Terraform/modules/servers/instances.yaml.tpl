instances:

    %{ for index, ip in elastic_ips }
    - name: elastic-${index + 1}
      dns:
        - localhost
        - elastic-${index + 1}
        - elastic-${index + 1}-public

    %{ endfor }
