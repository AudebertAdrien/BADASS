HOST_IMG   = host_aaudeber
ROUTER_IMG = router_aaudeber

GREEN = \033[0;32m
RESET = \033[0m

all: build

build:
	@echo "$(GREEN)--> Building $(HOST_IMG)...$(RESET)"
	@docker build -q -t $(HOST_IMG):latest ./host
	@echo "$(GREEN)--> Building $(ROUTER_IMG)...$(RESET)"
	@docker build -q -t $(ROUTER_IMG):latest ./router
	@echo "$(GREEN)=== P3 Images are successfully built! ===$(RESET)"

clean:
	@docker rmi $(HOST_IMG):latest $(ROUTER_IMG):latest 2>/dev/null || true
	@echo "$(GREEN)=== Cleanup finished ===$(RESET)"

.PHONY: all build clean
