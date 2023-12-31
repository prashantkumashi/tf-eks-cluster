
locals {
  eks-node-private-userdata = <<USERDATA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash -xe
sudo /etc/eks/bootstrap.sh --enable-docker-bridge true --apiserver-endpoint '${aws_eks_cluster.sampleprivatecluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.sampleprivatecluster.certificate_authority[0].data}' '${aws_eks_cluster.sampleprivatecluster.name}'
echo "Running custom user data script" > /tmp/me.txt
yum install -y amazon-ssm-agent
echo "yum'd agent" >> /tmp/me.txt
yum update -y
systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent
date >> /tmp/me.txt
#CA_CERTIFICATE_DIRECTORY=/etc/kubernetes/pki
#CA_CERTIFICATE_FILE_PATH=$CA_CERTIFICATE_DIRECTORY/ca.crt
#mkdir -p $CA_CERTIFICATE_DIRECTORY
#echo "${aws_eks_cluster.sampleprivatecluster.certificate_authority.0.data}" | base64 -d >  $CA_CERTIFICATE_FILE_PATH
#INTERNAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
#sed -i s,MASTER_ENDPOINT,${aws_eks_cluster.sampleprivatecluster.endpoint},g /var/lib/kubelet/kubeconfig
#sed -i s,CLUSTER_NAME,${var.cluster-name},g /var/lib/kubelet/kubeconfig
#sed -i s,REGION,${data.aws_region.current.name},g /etc/systemd/system/kubelet.service
#sed -i s,MAX_PODS,20,g /etc/systemd/system/kubelet.service
#sed -i s,MASTER_ENDPOINT,${aws_eks_cluster.sampleprivatecluster.endpoint},g /etc/systemd/system/kubelet.service
#sed -i s,INTERNAL_IP,$INTERNAL_IP,g /etc/systemd/system/kubelet.service
#DNS_CLUSTER_IP=10.100.0.10
#if [[ $INTERNAL_IP == 10.* ]] ; then DNS_CLUSTER_IP=172.20.0.10; fi
#sed -i s,DNS_CLUSTER_IP,$DNS_CLUSTER_IP,g /etc/systemd/system/kubelet.service
#sed -i s,CERTIFICATE_AUTHORITY_FILE,$CA_CERTIFICATE_FILE_PATH,g /var/lib/kubelet/kubeconfig
#sed -i s,CLIENT_CA_FILE,$CA_CERTIFICATE_FILE_PATH,g  /etc/systemd/system/kubelet.service
#systemctl daemon-reload
#systemctl restart kubelet

--==MYBOUNDARY==--
USERDATA
}
