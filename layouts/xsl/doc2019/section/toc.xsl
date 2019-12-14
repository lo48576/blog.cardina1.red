<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="d:article" mode="ds:toc">
	<xsl:param name="max-depth" select="3" />

	<details class="toc" open="open">
		<summary>
			<xsl:text>目次</xsl:text>
		</summary>
		<xsl:apply-templates select="." mode="ds:toc-group">
			<xsl:with-param name="max-depth" select="$max-depth" />
		</xsl:apply-templates>
	</details>
</xsl:template>

<xsl:template match="d:*" mode="ds:toc-group">
	<xsl:param name="depth" select="1" />
	<xsl:param name="max-depth" select="3" />
	<xsl:variable name="num-items">
		<xsl:apply-templates select="." mode="ds:count-toc-items" />
	</xsl:variable>

	<xsl:if test="($depth &lt;= $max-depth) and ($num-items &gt; 0)">
		<ul>
			<xsl:apply-templates select="d:section" mode="ds:toc-item">
				<xsl:with-param name="max-depth" select="$max-depth" />
			</xsl:apply-templates>
		</ul>
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:toc-item" />

<xsl:template match="d:section[contains(concat(' ', normalize-space(@role), ' '), ' notoc ')]" mode="ds:toc-item" />

<xsl:template match="d:section" mode="ds:toc-item">
	<xsl:param name="depth" select="1" />
	<xsl:param name="max-depth" select="3" />

	<xsl:if test="$depth &lt;= $max-depth">
		<li>
			<a class="toc-item">
				<xsl:if test="@xml:id">
					<xsl:attribute name="href">
						<xsl:call-template name="ds:link-resolve-xref">
							<xsl:with-param name="value" select="@xml:id" />
						</xsl:call-template>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="." mode="ds:xref-label" />
			</a>
			<xsl:apply-templates select="." mode="ds:toc-group">
				<xsl:with-param name="max-depth" select="$max-depth" />
			</xsl:apply-templates>
		</li>
	</xsl:if>
</xsl:template>


<!-- Counts the number of child sections to be indexed. -->
<xsl:template match="*" mode="ds:count-toc-items">
	<xsl:value-of select="count(d:section[not(contains(concat(' ', normalize-space(@role), ' '), ' notoc '))])" />
</xsl:template>

</xsl:stylesheet>
