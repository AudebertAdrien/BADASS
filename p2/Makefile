# ==========================================
# Docker image variables
# ==========================================
HOST_IMG    = aaudeber-host
R1_STAT_IMG = aaudeber-r1-static
R2_STAT_IMG = aaudeber-r2-static
R1_MULT_IMG = aaudeber-r1-multi
R2_MULT_IMG = aaudeber-r2-multi

# ==========================================
# Colors for clean output
# ==========================================
GREEN = \033[0;32m
BLUE  = \033[0;34m
RESET = \033[0m

# ==========================================
# Main rules
# ==========================================

all: build

build: build_host build_static build_multicast
	@echo "$(GREEN)=== All P2 images are ready! ===$(RESET)"

# --- Dedicated commands for the evaluation ---

static: build_host build_static
	@echo "$(BLUE)=== Ready for the STATIC presentation ===$(RESET)"

multicast: build_host build_multicast
	@echo "$(BLUE)=== Ready for the MULTICAST presentation ===$(RESET)"

# ==========================================
# Build rules (Silent to avoid cluttering the screen)
# ==========================================
build_host:
	@echo "$(GREEN)--> Building $(HOST_IMG)...$(RESET)"
	@docker build -q -t $(HOST_IMG):latest ./host

build_static:
	@echo "$(GREEN)--> Building Static Routers...$(RESET)"
	@docker build -q -t $(R1_STAT_IMG):latest ./static/router1
	@docker build -q -t $(R2_STAT_IMG):latest ./static/router2

build_multicast:
	@echo "$(GREEN)--> Building Multicast Routers...$(RESET)"
	@docker build -q -t $(R1_MULT_IMG):latest ./multicast/router1
	@docker build -q -t $(R2_MULT_IMG):latest ./multicast/router2

# ==========================================
# Clean up
# ==========================================
clean:
	@echo "$(BLUE)--> Removing P2 images...$(RESET)"
	@docker rmi $(HOST_IMG):latest \
		$(R1_STAT_IMG):latest \
		$(R2_STAT_IMG):latest \
		$(R1_MULT_IMG):latest \
		$(R2_MULT_IMG):latest 2>/dev/null || true
	@echo "$(GREEN)=== Cleanup finished ===$(RESET)"

.PHONY: all build static multicast build_host build_static build_multicast clean
