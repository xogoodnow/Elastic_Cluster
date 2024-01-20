127.0.0.1 localhost

${join(" ", monitoring_private_ips)} monitoring-0

${join(" ", elastic_0_private_ips)} elastic-1
${join(" ", elastic_1_private_ips)} elastic-2
${join(" ", elastic_2_private_ips)} elastic-3


%{ for index, ip in elastic_ips }
${ip}    elastic-${index + 1}-public
%{ endfor }


%{ for index, ip in monitoring_ips }
${ip}    monitoring-${index}-public
%{ endfor }

ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

