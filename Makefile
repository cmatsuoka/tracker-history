
AMIGA_TRACKERS	= soundtracker noisetracker startrekker protracker med \
		  other-amiga

PC_TRACKERS	= fasttracker screamtracker impulsetracker other-pc

TODOT		= ./todot
TRACKERS	= $(addsuffix .txt, $(AMIGA_TRACKERS)) \
		  $(addsuffix .txt, $(PC_TRACKERS)) 



all: trackers.svg

trackers.svg: trackers.dot
	dot -Tsvg -o$@ trackers.dot
	
trackers.dot: $(TRACKERS) $(TODOT) Makefile
	$(TODOT) $(TRACKERS) > $@

