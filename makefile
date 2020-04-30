SRCS = $(wildcard  *.c)
OBJS = $(patsubst %.c, %.o,$(SRCS))
OUTPUT = $(shell pwd)/build

TARGETS = $(OUTPUT)/a.out

SUBDIRS=$(shell ls -l | grep ^d | awk -f subdirs.awk)

SUB_TARS_SUFFIX = .subtars

SUB_OBJS = $(addprefix $(OUTPUT)/,$(SUBDIRS))
SUBDIRS_OBJS = $(addsuffix $(SUB_TARS_SUFFIX),$(SUB_OBJS))

export OUTPUT

.PHONY:all app

app:$(TARGETS) 
	@echo app

$(TARGETS):$(SUBDIRS_OBJS)
	@echo 生成:$@ $<
	touch $@

all:app
	@echo all

$(OBJS):%.o:%.c
	@echo $@ $^

$(SUBDIRS_OBJS):$(OUTPUT)/%$(SUB_TARS_SUFFIX):%
	make -C $^ SUBTARGET=$^

clean:
	@rm $(OUTPUT)/*$(SUB_TARS_SUFFIX)

