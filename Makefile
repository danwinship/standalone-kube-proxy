all: build
.PHONY: all

GO_BUILD_PACKAGES=./vendor/k8s.io/kubernetes/cmd/kube-proxy

K8S_GIT_VERSION=$(shell sed -n -e 's/\tk8s.io\/kubernetes //p' go.mod)
GO_LD_FLAGS = -ldflags "-X k8s.io/component-base/version.gitVersion=$(K8S_GIT_VERSION)-ocp $(GO_LD_EXTRAFLAGS)"

include $(addprefix ./vendor/github.com/openshift/build-machinery-go/make/, \
	golang.mk \
	targets/openshift/images.mk \
)

# generates target "image-kube-proxy" to build "origin-kube-proxy" image from
# "./Dockerfile" in "."
$(call build-image,kube-proxy,origin-kube-proxy,./Dockerfile,.)
