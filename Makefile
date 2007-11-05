
AMIGA_TRACKERS	= soundtracker noisetracker startrekker protracker med \
		  other-amiga

PC_TRACKERS	= fasttracker screamtracker impulsetracker other-pc

TODOT		= ./todot
TRACKERS	= $(addsuffix .txt, $(AMIGA_TRACKERS)) \
		  $(addsuffix .txt, $(PC_TRACKERS)) 

DATE		= `date +%Y%m%d`
THPKG		= tracker-history
THDIR		= tracker-history-$(DATE)


all: trackers.svg trackers.ps

trackers.svg: trackers.dot
	dot -Tsvg -o$@ trackers.dot
	
trackers.ps: trackers.dot
	dot -Tps -o$@ trackers.dot
	
trackers.dot: $(TRACKERS) $(TODOT) Makefile
	$(TODOT) $(TRACKERS) > $@

dist:
	rm -Rf $(THDIR)
	mkdir $(THDIR)
	cp Makefile README $(TODOT) $(TRACKERS) $(THDIR)/
	tar cf - $(THDIR) | gzip -c > $(THPKG)
	rm -Rf $(THDIR)
	ls -l $(THPKG)
