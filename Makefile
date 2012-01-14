
AMIGA_TRACKERS	= soundtracker noisetracker startrekker protracker med \
		  digibooster tfmx oktalyzer other-amiga

# These are actually the MS-DOS trackers
PC_TRACKERS	= fasttracker screamtracker impulsetracker digitrakker \
		  realtracker other-pc

WIN_TRACKERS	= modplugtracker buzz other-windows

# Any Unix goes here
LINUX_TRACKERS	= other-linux

# Portable or not tied to a specific platform
PORT_TRACKERS	= schism skale milkytracker chibi renoise other-portable

TODOT		= ./todot
TRACKERS	= def-amiga.txt  $(addsuffix .txt, $(AMIGA_TRACKERS)) \
		  def-pc.txt     $(addsuffix .txt, $(PC_TRACKERS)) \
		  def-win.txt    $(addsuffix .txt, $(WIN_TRACKERS)) \
		  def-linux.txt  $(addsuffix .txt, $(LINUX_TRACKERS)) \
		  def-port.txt   $(addsuffix .txt, $(PORT_TRACKERS)) \

DATE		= `date +%Y%m%d`
THPKG		= tracker-history.tar.gz
THDIR		= tracker-history-$(DATE)


all: trackers.svg trackers.ps

trackers.svg: trackers.dot
	dot -Tsvg -o$@ trackers.dot
	perl -pi -e 's|(^<svg).*|$$1|;s|.*?(xmlns.*)|$$1\n<script xlink:href="SVGPan.js"/>|' $@

trackers.ps: trackers.dot
	dot -Tps -o$@ trackers.dot
	
trackers.dot: $(TRACKERS) $(TODOT) Makefile
	$(TODOT) $(TRACKERS) > $@

dist:
	rm -Rf $(THDIR)
	mkdir $(THDIR)
	cp Makefile README SVGPan.js $(TODOT) $(TRACKERS) $(THDIR)/
	tar cf - $(THDIR) | gzip -c > $(THPKG)
	rm -Rf $(THDIR)
	ls -l $(THPKG)
