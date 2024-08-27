FROM registry.ci.openshift.org/ocp/builder:rhel-9-golang-1.22-openshift-4.17 AS builder
WORKDIR /go/src/github.com/openshift/standalone-kube-proxy
COPY . .
RUN make build --warn-undefined-variables

FROM registry.ci.openshift.org/ocp/4.17:base-rhel9
RUN INSTALL_PKGS="conntrack-tools iptables nftables" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum clean all && rm -rf /var/cache/*

COPY --from=builder /go/src/github.com/openshift/standalone-kube-proxy/kube-proxy /usr/bin/

LABEL io.k8s.display-name="Kubernetes kube-proxy" \
      io.k8s.description="Provides kube-proxy for external CNI plugins" \
      io.openshift.tags="openshift,kube-proxy"
