.PHONY: all

all: scamp.html.tpl
clean:
	$(RM) scamp.html.tpl

scamp.html.tpl: scamp_out.html scamp_out.js
	cat scamp_out.html   > scamp.html.tpl
	echo "<script>"     >> scamp.html.tpl
	cat scamp_out.js    >> scamp.html.tpl
	echo "</script>"    >> scamp.html.tpl
