
AMIGA_TRACKERS	= soundtracker noisetracker startrekker protracker med \
		  other-amiga

PC_TRACKERS	= fasttracker screamtracker impulsetracker

TODOT		= ./todot
TRACKERS	= $(addsuffix .txt, $(AMIGA_TRACKERS)) \
		  $(addsuffix .txt, $(PC_TRACKERS)) 



all: trackers.svg

trackers.svg: trackers.dot
	dot -Tsvg -o$@ trackers.dot
	
trackers.dot: $(TRACKERS) $(TODOT)
	$(TODOT) $(TRACKERS) > $@

