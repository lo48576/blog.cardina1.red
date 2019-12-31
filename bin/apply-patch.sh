#!/bin/sh
set -u

cd "$(dirname "$(readlink -f "$0")")/.."

################

RACK_LIVERELOAD_PATH="$(realpath --relative-to=. "$(bundle info --path rack-livereload)")"
echo "rack-livereload: ${RACK_LIVERELOAD_PATH}"

patch -p0 <<__EOF__
diff -Naur ${RACK_LIVERELOAD_PATH}/lib/rack/livereload/processing_skip_analyzer.rb rack-livereload-0.3.17/lib/rack/livereload/processing_skip_analyzer.rb
--- ${RACK_LIVERELOAD_PATH}/lib/rack/livereload/processing_skip_analyzer.rb 2019-11-29 19:20:38.213601705 +0900
+++ ${RACK_LIVERELOAD_PATH}/lib/rack/livereload/processing_skip_analyzer.rb      2019-11-29 22:43:58.691183891 +0900
@@ -37,7 +37,7 @@
       end

       def html?
-        @headers['Content-Type'] =~ %r{text/html}
+        @headers['Content-Type'] =~ %r{text/html|application/xhtml\+xml}
       end

       def get?
__EOF__

################

NANOC_PATH="$(realpath --relative-to=. "$(bundle info --path nanoc)")"
echo "nanoc-path: ${NANOC_PATH}"

patch -p0 <<__EOF__
diff -Naur ${NANOC_PATH}/lib/nanoc/filters/colorize_syntax.rb ${NANOC_PATH}/lib/nanoc/filters/colorize_syntax.rb
--- ${NANOC_PATH}/lib/nanoc/filters/colorize_syntax.rb	2018-09-13 01:23:19.096066864 +0900
+++ ${NANOC_PATH}/lib/nanoc/filters/colorize_syntax.rb	2018-09-13 01:28:32.179975348 +0900
@@ -21,8 +21,8 @@

       # Colorize
       doc = parse(content, parser, params.fetch(:is_fullpage, false))
-      selector = params[:outside_pre] ? 'code' : 'pre > code'
-      doc.css(selector).each do |element|
+      selector = params[:outside_pre] ? './/*[local-name()="code"]' : './/*[local-name()="pre"]/*[local-name()="code"]'
+      doc.xpath(selector).each do |element|
         # Get language
         extracted_language = extract_language(element)

__EOF__
