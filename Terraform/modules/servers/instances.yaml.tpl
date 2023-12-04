%{ for index, ip in elastic_ips }
- name: elastic-${index}
  dns:
    - localhost
    - elastic-${index}
    - elastic-${index}-public

%{ endfor }
