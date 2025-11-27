################################################################################
# bao-virtio-dm Buildroot package
################################################################################

BAO_VIRTIO_DM_VERSION = main
BAO_VIRTIO_DM_SITE = https://github.com/bao-project/bao-virtio-dm.git
BAO_VIRTIO_DM_SITE_METHOD = git

BAO_VIRTIO_DM_LICENSE = Apache-2.0
BAO_VIRTIO_DM_LICENSE_FILES = LICENSE

ifeq ($(ARCH),aarch64)
BAO_VIRTIO_DM_TARGET = aarch64-unknown-linux-gnu
else ifeq ($(ARCH),riscv64)
BAO_VIRTIO_DM_TARGET = riscv64gc-unknown-linux-gnu
else
BAO_VIRTIO_DM_TARGET = arm-unknown-linux-gnueabi
endif

define BAO_VIRTIO_DM_BUILD_CMDS
	cd $(@D) && \
	cargo build \
	    --release \
		--locked \
	    --target $(BAO_VIRTIO_DM_TARGET)
endef

define BAO_VIRTIO_DM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 \
	    $(@D)/target/$(BAO_VIRTIO_DM_TARGET)/release/bao-virtio-dm \
	    $(TARGET_DIR)/bin/bao-virtio-dm
endef

define BAO_VIRTIO_DM_CLEAN_CMDS
	cd $(@D) && cargo clean
endef

$(eval $(generic-package))
