<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds"
>
<xsl:include href="attr/common.xsl" />
<xsl:include href="block.xsl" />
<xsl:include href="blockquote.xsl" />
<xsl:include href="code.xsl" />
<xsl:include href="ext/html.xsl" />
<xsl:include href="ext/mathml.xsl" />
<xsl:include href="ext/svg.xsl" />
<xsl:include href="figure.xsl" />
<xsl:include href="footnote/footnote.xsl" />
<xsl:include href="footnote/footnotes.xsl" />
<xsl:include href="footnote/lib.xsl" />
<xsl:include href="inline.xsl" />
<xsl:include href="link/lib.xsl" />
<xsl:include href="link/link.xsl" />
<xsl:include href="media.xsl" />
<xsl:include href="multi-entry/desclist.xsl" />
<xsl:include href="multi-entry/list.xsl" />
<xsl:include href="multi-entry/table.xsl" />
<xsl:include href="params.xsl" />
<xsl:include href="quote.xsl" />
<xsl:include href="section/lib.xsl" />
<xsl:include href="section/section.xsl" />
<xsl:include href="section/toc.xsl" />

<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:strip-space elements="d:*" />
<xsl:preserve-space elements="d:literallayout d:programlisting d:screen" />

<xsl:template match="d:*" mode="ds:inner">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="d:*">
	<xsl:if test="$ds:show-unimplemented = 'yes'">
		<xsl:choose>
			<xsl:when test="node() | text()">
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;d:</xsl:text>
					<xsl:value-of select="name()" />
					<xsl:for-each select="@*">
						<xsl:text> </xsl:text>
						<xsl:value-of select="name()" />
						<xsl:text>="</xsl:text>
						<xsl:value-of select="." />
						<xsl:text>"</xsl:text>
					</xsl:for-each>
					<xsl:text>&gt;</xsl:text>
				</span>
				<span>
					<xsl:apply-templates select="." mode="ds:attr-common" />
					<xsl:apply-templates select="." mode="ds:inner" />
				</span>
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;/d:</xsl:text>
					<xsl:value-of select="local-name()" />
					<xsl:text>&gt;</xsl:text>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;d:</xsl:text>
					<xsl:value-of select="name()" />
					<xsl:for-each select="@*">
						<xsl:text> </xsl:text>
						<xsl:value-of select="name()" />
						<xsl:text>="</xsl:text>
						<xsl:value-of select="." />
						<xsl:text>"</xsl:text>
					</xsl:for-each>
					<xsl:text> /&gt;</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

<xsl:template match="*">
	<xsl:if test="$ds:show-unimplemented = 'yes'">
		<xsl:choose>
			<xsl:when test="node() | text()">
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;</xsl:text>
					<xsl:value-of select="name()" />
					<xsl:for-each select="@*">
						<xsl:text> </xsl:text>
						<xsl:value-of select="name()" />
						<xsl:text>="</xsl:text>
						<xsl:value-of select="." />
						<xsl:text>"</xsl:text>
					</xsl:for-each>
					<xsl:text>&gt;</xsl:text>
				</span>
				<span>
					<xsl:apply-templates select="." mode="ds:attr-common" />
					<xsl:apply-templates select="." mode="ds:inner" />
				</span>
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;/</xsl:text>
					<xsl:value-of select="local-name()" />
					<xsl:text>&gt;</xsl:text>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span style="color: red; font-weight: bolder;">
					<xsl:text>&lt;</xsl:text>
					<xsl:value-of select="name()" />
					<xsl:for-each select="@*">
						<xsl:text> </xsl:text>
						<xsl:value-of select="name()" />
						<xsl:text>="</xsl:text>
						<xsl:value-of select="." />
						<xsl:text>"</xsl:text>
					</xsl:for-each>
					<xsl:text> /&gt;</xsl:text>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
