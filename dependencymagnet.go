//go:build tools

package main

import (
	_ "github.com/openshift/build-machinery-go"
	_ "k8s.io/kubernetes/cmd/kube-proxy"
)
