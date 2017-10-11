
LVL_BUILD_DIR = BUILD
LVL_MAKEFILE = $(LVL_BUILD_DIR)/Makefile
LVL_EXTERNAL = external

all: x

$(LVL_EXTERNAL):
	./update_external_sources.sh

$(LVL_BUILD_DIR): $(LVL_EXTERNAL)
	mkdir $@

$(LVL_MAKEFILE): $(LVL_BUILD_DIR)
	cd $(LVL_BUILD_DIR) && cmake ..

x: $(LVL_MAKEFILE)
	VK_LAYER_PATH="`pwd`/layers" time nice $(MAKE) -C $(LVL_BUILD_DIR) VERBOSE=1

clean:
	-rm -rf $(LVL_BUILD_DIR)

clobber: clean
	-rm -rf $(LVL_EXTERNAL)
