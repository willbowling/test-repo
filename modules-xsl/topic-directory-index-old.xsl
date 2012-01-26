<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Force the output to be strict XHTML -->
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"></xsl:output>
	<xsl:param name="class_id"></xsl:param>
	<xsl:param name="image_server_url">
		<xsl:text>http://img.preview.webmd.com/dtmcms/preview</xsl:text>
	</xsl:param>
	<xsl:param name="moduletitle"></xsl:param>
	<xsl:param name="site_id">3</xsl:param>
	<xsl:param name="domain">webmd.com</xsl:param>
	<xsl:param name="is_tagged_to_topic_dir"></xsl:param>
	<xsl:param name="page"></xsl:param>
	<xsl:param name="catid"></xsl:param>
	<xsl:param name="sortorder"></xsl:param>
	<xsl:param name="identity">1</xsl:param>
	<xsl:param name="medref_id">
		<xsl:text>1006</xsl:text>
	</xsl:param>
	<xsl:param name="news_id">
		<xsl:text>1005</xsl:text>
	</xsl:param>
	<xsl:param name="features_id">
		<xsl:text>1003</xsl:text>
	</xsl:param>
	<xsl:param name="videos_id">
		<xsl:text>1009</xsl:text>
	</xsl:param>
	<xsl:param name="slideshows_images_id">
		<xsl:text>1008</xsl:text>
	</xsl:param>
	<xsl:param name="health_tools_id">
		<xsl:text>1004</xsl:text>
	</xsl:param>
	<xsl:param name="recipes_id">
		<xsl:text>1007</xsl:text>
	</xsl:param>
	<xsl:param name="exp_commentary_id">
		<xsl:text>1002</xsl:text>
	</xsl:param>
	<xsl:param name="answers_id">
		<xsl:text>1012</xsl:text>
	</xsl:param>
	<xsl:param name="drugs_id">
		<xsl:text>1001</xsl:text>
	</xsl:param>
	<xsl:param name="vit_supp_id">
		<xsl:text>1011</xsl:text>
	</xsl:param>
	<xsl:param name="wbmd_commun_id">
		<xsl:text>1010</xsl:text>
	</xsl:param>
	<xsl:param name="partner_id">
		<xsl:text>1013</xsl:text>
	</xsl:param>
	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--
is_tagged_to_topic_dir = ]]></xsl:text>
		<xsl:value-of select="$is_tagged_to_topic_dir"></xsl:value-of>
		<xsl:text disable-output-escaping="yes"><![CDATA[
page = ]]></xsl:text>
		<xsl:value-of select="$page"></xsl:value-of>
		<xsl:text disable-output-escaping="yes"><![CDATA[
catid = ]]></xsl:text>
		<xsl:value-of select="$catid"></xsl:value-of>
		<xsl:text disable-output-escaping="yes"><![CDATA[
sortorder = ]]></xsl:text>
		<xsl:value-of select="$sortorder"></xsl:value-of>
		<xsl:text disable-output-escaping="yes"><![CDATA[
moduletitle = ]]></xsl:text>
		<xsl:value-of select="$moduletitle"></xsl:value-of>
		<xsl:text disable-output-escaping="yes"><![CDATA[
-->
]]></xsl:text>
		<xsl:if test="$identity=1">
			<xsl:call-template name="CreateIdentity"></xsl:call-template>
		</xsl:if>
		<xsl:element name="div">
			<xsl:attribute name="class"><xsl:text>topic_index</xsl:text><xsl:if test="$catid != ''"><xsl:text><![CDATA[ topic_seeall]]></xsl:text></xsl:if></xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="$moduletitle"></xsl:value-of></xsl:attribute>
			<xsl:if test="not(/webmd_rendition/topic_dirs/topic_dir)">
				<xsl:text>no data</xsl:text>
			</xsl:if>
			<xsl:apply-templates select="/webmd_rendition/topic_dirs/topic_dir"></xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	<xsl:template match="topic_dir">
		<xsl:choose>
			<xsl:when test="$catid = ''">
				<xsl:call-template name="CreateIndexPage"></xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="CreateSeeAllPage"></xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CreateIndexPage">
		<xsl:element name="p">
			<xsl:value-of select="description" disable-output-escaping="yes"></xsl:value-of>
		</xsl:element>
		<xsl:for-each select="categories/category[@id=$slideshows_images_id]">
			<xsl:call-template name="CreateFeatBulleted">
				<xsl:with-param name="category">
					<xsl:call-template name="GetCategory">
						<xsl:with-param name="category_id">
							<xsl:value-of select="@id"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="categories/category[@id=$medref_id]">
			<xsl:call-template name="CreateFeatBulleted">
				<xsl:with-param name="category">
					<xsl:call-template name="GetCategory">
						<xsl:with-param name="category_id">
							<xsl:value-of select="@id"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="categories/category[@id=$news_id]">
			<xsl:call-template name="CreateFeatBulleted">
				<xsl:with-param name="category">
					<xsl:call-template name="GetCategory">
						<xsl:with-param name="category_id">
							<xsl:value-of select="@id"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="categories/category[@id=$features_id]">
			<xsl:call-template name="CreateFeatBulleted">
				<xsl:with-param name="category">
					<xsl:call-template name="GetCategory">
						<xsl:with-param name="category_id">
							<xsl:value-of select="@id"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="categories/category[@id=$health_tools_id]">
			<xsl:call-template name="CreateFeatBulleted">
				<xsl:with-param name="category">
					<xsl:call-template name="GetCategory">
						<xsl:with-param name="category_id">
							<xsl:value-of select="@id"></xsl:value-of>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CreateFeatBulleted">
		<xsl:param name="category"></xsl:param>
		<xsl:if test="count(assets/asset) &gt; 0">
		<xsl:element name="div">
		<xsl:attribute name="class"><xsl:text>cat_</xsl:text><xsl:value-of select="@id"></xsl:value-of></xsl:attribute>
			<xsl:element name="h3">
				<xsl:value-of select="name" disable-output-escaping="yes"></xsl:value-of>
			</xsl:element>
			<!--Create Thumb, Text, and Link (News and Features section only)-->
			<xsl:if test="@id = $news_id or @id = $features_id">
				<xsl:element name="div">
					<xsl:attribute name="class"><xsl:text>feat_sect clearfix</xsl:text></xsl:attribute>
					<xsl:call-template name="GetImg">
						<xsl:with-param name="src">
							<xsl:choose>
								<xsl:when test="assets/asset[1]/thumbnail != ''">
									<xsl:value-of select="assets/asset[1]/thumbnail"></xsl:value-of>
								</xsl:when>
								<xsl:when test="@id = $features_id">
									<xsl:value-of select="$image_server_url"></xsl:value-of>
									<xsl:text>/webmd/consumer_assets/site_images/articles/thumbnails_daily_images/default.jpg</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$image_server_url"></xsl:value-of>
									<xsl:text>/webmd/consumer_assets/site_images/articles/thumbnails_daily_images/default.jpg</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="alt">
							<xsl:text>Thumbnail: </xsl:text>
							<xsl:value-of select="assets/asset[1]/link_title"></xsl:value-of>
						</xsl:with-param>
						<xsl:with-param name="class">
							<xsl:text>topic_img</xsl:text>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="assets/asset[1]/description != ''">
						<xsl:element name="p">
							<xsl:attribute name="class"><xsl:text>topic_desc</xsl:text></xsl:attribute>
							<xsl:value-of select="assets/asset[1]/description" disable-output-escaping="yes"></xsl:value-of>
						</xsl:element>
						<xsl:element name="p">
							<xsl:attribute name="class"><xsl:text>topic_action</xsl:text></xsl:attribute>
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:value-of select="assets/asset[1]/friendly_url" disable-output-escaping="yes"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-</xsl:text><xsl:value-of select="$category"></xsl:value-of><xsl:text>_more</xsl:text></xsl:with-param></xsl:call-template></xsl:attribute>
								<xsl:text>Read Full Article</xsl:text>
							</xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:if>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>list_area</xsl:text></xsl:attribute>
				<xsl:variable name="start">
					<xsl:choose>
						<xsl:when test="(assets/asset[1]/thumbnail != '' or assets/asset[1]/description != '') and (@id = $news_id or @id = $features_id)">
							<xsl:text>1</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>0</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:element name="ul">
					<xsl:for-each select="assets/asset[position() &gt; $start and position() &lt; 5]">
						<xsl:element name="li">
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:value-of select="friendly_url"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-</xsl:text><xsl:value-of select="$category"></xsl:value-of><xsl:text>_</xsl:text><xsl:value-of select="position()"></xsl:value-of></xsl:with-param></xsl:call-template></xsl:attribute>
								<xsl:value-of select="link_title" disable-output-escaping="yes"></xsl:value-of>
							</xsl:element>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
				<xsl:if test="count(assets/asset) &gt; 4">
					<xsl:element name="div">
						<xsl:attribute name="class"><xsl:text>see_all</xsl:text></xsl:attribute>
						<xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="friendly_url"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-</xsl:text><xsl:value-of select="$category"></xsl:value-of><xsl:text>_more</xsl:text></xsl:with-param></xsl:call-template></xsl:attribute>
							<xsl:text>See All</xsl:text>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:element>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template name="CreateSeeAllPage">
		<!--Since the page parameter is pulled directly from a query string, it may be blank when on page 1.  Set current page to 1 when this it the case.-->
		<xsl:variable name="current_page">
			<xsl:choose>
				<xsl:when test="$page = ''">
					<xsl:text>1</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$page"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="last_page">
			<xsl:value-of select="ceiling(count(categories/category[@id=$catid]/assets/asset) div 50)"></xsl:value-of>
		</xsl:variable>
		<xsl:variable name="category">
			<xsl:call-template name="GetCategory">
				<xsl:with-param name="category_id">
					<xsl:value-of select="$catid"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:element name="script">
			<xsl:attribute name="type"><xsl:text>text/javascript</xsl:text></xsl:attribute>
			<xsl:text><![CDATA[var s_page_suffix = ']]></xsl:text>
			<xsl:value-of select="$category"></xsl:value-of>
			<xsl:text><![CDATA[';]]></xsl:text>
		</xsl:element>
		<xsl:element name="div">
		<xsl:attribute name="class"><xsl:text>cat_</xsl:text><xsl:value-of select="$catid"></xsl:value-of></xsl:attribute>
		<xsl:for-each select="categories/category[@id=$catid]">
			<xsl:element name="h3">
				<xsl:value-of select="name" disable-output-escaping="yes"></xsl:value-of>
			</xsl:element>
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>sort</xsl:text></xsl:attribute>
				<xsl:element name="strong">
					<xsl:text>Sort by: </xsl:text>
				</xsl:element>
				<xsl:element name="span">
					<xsl:choose>
						<xsl:when test="$sortorder!='title'">
							<xsl:attribute name="class"><xsl:text>on</xsl:text></xsl:attribute>
							<xsl:text>Date</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:value-of select="friendly_url"></xsl:value-of><xsl:text disable-output-escaping="yes"><![CDATA[&page=]]></xsl:text><xsl:value-of select="$current_page"></xsl:value-of></xsl:attribute>
								<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-srt-nav_dt</xsl:text></xsl:with-param></xsl:call-template></xsl:attribute>
								<xsl:text>Date</xsl:text>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
				<xsl:element name="span">
					<xsl:choose>
						<xsl:when test="$sortorder = 'title'">
							<xsl:attribute name="class"><xsl:text>on</xsl:text></xsl:attribute>
							<xsl:text>A-Z</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:value-of select="friendly_url"></xsl:value-of><xsl:text disable-output-escaping="yes"><![CDATA[&page=]]></xsl:text><xsl:value-of select="$current_page"></xsl:value-of><xsl:text disable-output-escaping="yes"><![CDATA[&sortorder=title]]></xsl:text></xsl:attribute>
								<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-srt-nav_az</xsl:text></xsl:with-param></xsl:call-template></xsl:attribute>
								<xsl:text>A-Z</xsl:text>
							</xsl:element>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:element>
			<!--List-->
			<xsl:element name="ul">
				<xsl:variable name="start">
					<xsl:value-of select="number(($current_page * 50) - 50)"></xsl:value-of>
				</xsl:variable>
				<xsl:variable name="end">
					<xsl:value-of select="number(($current_page * 50) + 1)"></xsl:value-of>
				</xsl:variable>
				<xsl:for-each select="assets/asset[position() &gt; $start and position() &lt; $end]">
					<xsl:element name="li">
						<xsl:element name="a">
							<xsl:attribute name="href"><xsl:value-of select="friendly_url"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-seeall-list_</xsl:text><xsl:value-of select="position() + $start"></xsl:value-of></xsl:with-param></xsl:call-template></xsl:attribute>
							<xsl:value-of select="link_title" disable-output-escaping="yes"></xsl:value-of>
						</xsl:element>
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
		</xsl:for-each>
		</xsl:element>
		
		<!--Pagination-->
		<xsl:if test="$last_page &gt; 1">
			<xsl:element name="div">
				<xsl:attribute name="class"><xsl:text>pagination</xsl:text></xsl:attribute>
				<!--Previous Page Button-->
				<xsl:if test="$current_page &gt; 1">
					<xsl:element name="a">
						<xsl:attribute name="href"><xsl:value-of select="categories/category[@id=$catid]/friendly_url"></xsl:value-of><xsl:text disable-output-escaping="yes"><![CDATA[&page=]]></xsl:text><xsl:value-of select="$current_page - 1"></xsl:value-of><xsl:if test="$sortorder = 'title'"><xsl:text disable-output-escaping="yes"><![CDATA[&sortorder=title]]></xsl:text></xsl:if></xsl:attribute>
						<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-seeall-list_prev</xsl:text></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:call-template name="GetImg">
							<xsl:with-param name="src">
								<xsl:value-of select="$image_server_url"></xsl:value-of>
								<xsl:text>/webmd/consumer_assets/site_images/modules/2009_funded/pagination-prev.gif</xsl:text>
							</xsl:with-param>
							<xsl:with-param name="alt">
								<xsl:text>Click to go to previous page</xsl:text>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:if>
				<xsl:call-template name="CreatePageSpan">
					<xsl:with-param name="counter">
						<xsl:text>1</xsl:text>
					</xsl:with-param>
					<xsl:with-param name="last_page">
						<xsl:value-of select="$last_page"></xsl:value-of>
					</xsl:with-param>
					<xsl:with-param name="current_page">
						<xsl:value-of select="$current_page"></xsl:value-of>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$current_page &lt; $last_page">
					<xsl:element name="a">
						<xsl:attribute name="href"><xsl:value-of select="categories/category[@id=$catid]/friendly_url"></xsl:value-of><xsl:text disable-output-escaping="yes"><![CDATA[&page=]]></xsl:text><xsl:value-of select="$current_page + 1"></xsl:value-of><xsl:if test="$sortorder = 'title'"><xsl:text disable-output-escaping="yes"><![CDATA[&sortorder=title]]></xsl:text></xsl:if></xsl:attribute>
						<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-seeall-list_next</xsl:text></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:call-template name="GetImg">
							<xsl:with-param name="src">
								<xsl:value-of select="$image_server_url"></xsl:value-of>
								<xsl:text>/webmd/consumer_assets/site_images/modules/2009_funded/pagination-next.gif</xsl:text>
							</xsl:with-param>
							<xsl:with-param name="alt">
								<xsl:text>Click to go to next page</xsl:text>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template name="CreatePageSpan">
		<xsl:param name="counter"></xsl:param>
		<xsl:param name="last_page"></xsl:param>
		<xsl:param name="current_page"></xsl:param>
		<xsl:if test="$counter &gt; 1">
			<xsl:element name="span">
				<xsl:text>|</xsl:text>
			</xsl:element>
		</xsl:if>
		<xsl:element name="span">
			<xsl:choose>
				<xsl:when test="$counter = $current_page">
					<xsl:attribute name="class"><xsl:text>on</xsl:text></xsl:attribute>
					<xsl:value-of select="$counter"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="a">
						<xsl:attribute name="href"><xsl:value-of select="categories/category[@id=$catid]/friendly_url"></xsl:value-of><xsl:text disable-output-escaping="yes"><![CDATA[&page=]]></xsl:text><xsl:value-of select="$counter"></xsl:value-of><xsl:if test="$sortorder = 'title'"><xsl:text disable-output-escaping="yes"><![CDATA[&sortorder=title]]></xsl:text></xsl:if></xsl:attribute>
						<xsl:attribute name="onclick"><xsl:call-template name="GetOnclickVal"><xsl:with-param name="tracking_val"><xsl:value-of select="$moduletitle"></xsl:value-of><xsl:text>-seeall-list_p-</xsl:text><xsl:value-of select="$counter"></xsl:value-of></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:value-of select="$counter"></xsl:value-of>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
		<xsl:if test="$counter &lt; $last_page">
			<xsl:call-template name="CreatePageSpan">
				<xsl:with-param name="counter">
					<xsl:value-of select="$counter + 1"></xsl:value-of>
				</xsl:with-param>
				<xsl:with-param name="last_page">
					<xsl:value-of select="$last_page"></xsl:value-of>
				</xsl:with-param>
				<xsl:with-param name="current_page">
					<xsl:value-of select="$current_page"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetCategory">
		<xsl:param name="category_id"></xsl:param>
		<xsl:choose>
			<xsl:when test="$category_id = $medref_id">
				<xsl:text>med-ref</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $news_id">
				<xsl:text>news</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $features_id">
				<xsl:text>features</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $videos_id">
				<xsl:text>vid</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $slideshows_images_id">
				<xsl:text>sld-shw</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $health_tools_id">
				<xsl:text>hlth-tools</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $recipes_id">
				<xsl:text>recipes</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $exp_commentary_id">
				<xsl:text>comm</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $answers_id">
				<xsl:text>answers</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $drugs_id">
				<xsl:text>drugs</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $vit_supp_id">
				<xsl:text>vit-sup</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $wbmd_commun_id">
				<xsl:text>commun</xsl:text>
			</xsl:when>
			<xsl:when test="$category_id = $partner_id">
				<xsl:text>partner</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="GetOnclickVal">
		<xsl:param name="link_type"></xsl:param>
		<xsl:param name="tracking_val"></xsl:param>
		<xsl:text>return sl(this,'</xsl:text>
		<xsl:value-of select="$link_type"></xsl:value-of>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="$tracking_val"></xsl:value-of>
		<xsl:text>');</xsl:text>
	</xsl:template>
	<xsl:template name="GetImg">
		<xsl:param name="src"></xsl:param>
		<xsl:param name="alt"></xsl:param>
		<xsl:param name="class"></xsl:param>
		<xsl:choose>
			<xsl:when test="$src != '' and $alt != '' and $class = ''">
				<img src="{$src}" alt="{$alt}"/>
			</xsl:when>
			<xsl:when test="$src != '' and $alt != '' and $class != ''">
				<img src="{$src}" alt="{$alt}" class="{$class}"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--Identity Templates-->
	<xsl:template name="CreateIdentity">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!--
updated 07/29/11 at 2:55pm
]]></xsl:text>
		<xsl:for-each select="/*">
			<xsl:apply-templates mode="identity" select="."></xsl:apply-templates>
		</xsl:for-each>
		<xsl:text disable-output-escaping="yes"><![CDATA[
-->
]]></xsl:text>
	</xsl:template>
	<xsl:template match="@*|*|processing-instruction()|comment()" mode="identity">
		<xsl:copy>
			<xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()" mode="identity"></xsl:apply-templates>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="text()" mode="identity">
		<xsl:choose>
			<xsl:when test="contains(., '--' )">
				<xsl:variable name="out1">
					<xsl:call-template name="ReplaceParams">
						<xsl:with-param name="orig_text">
							<xsl:value-of select="." disable-output-escaping="yes"></xsl:value-of>
						</xsl:with-param>
						<xsl:with-param name="param_to_replace">
							<xsl:text disable-output-escaping="yes">--</xsl:text>
						</xsl:with-param>
						<xsl:with-param name="param_value">
							<xsl:text disable-output-escaping="yes"><![CDATA[&#45;&#45;]]></xsl:text>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="$out1" disable-output-escaping="yes"></xsl:value-of>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."></xsl:value-of>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="ReplaceParams">
		<xsl:param name="orig_text"></xsl:param>
		<xsl:param name="parsed_text"></xsl:param>
		<xsl:param name="param_to_replace"></xsl:param>
		<xsl:param name="param_value"></xsl:param>
		<xsl:choose>
			<xsl:when test="$orig_text != ''">
				<xsl:choose>
					<xsl:when test="contains($orig_text, $param_to_replace)">
						<xsl:call-template name="ReplaceParams">
							<xsl:with-param name="orig_text">
								<xsl:value-of select="substring-after($orig_text, $param_to_replace)" disable-output-escaping="yes"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="parsed_text">
								<xsl:value-of select="$parsed_text" disable-output-escaping="yes"></xsl:value-of>
								<xsl:value-of select="substring-before($orig_text, $param_to_replace)" disable-output-escaping="yes"></xsl:value-of>
								<xsl:value-of select="$param_value" disable-output-escaping="yes"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_to_replace">
								<xsl:value-of select="$param_to_replace"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_value">
								<xsl:value-of select="$param_value"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ReplaceParams">
							<xsl:with-param name="orig_text"></xsl:with-param>
							<xsl:with-param name="parsed_text">
								<xsl:value-of select="concat($parsed_text, $orig_text)" disable-output-escaping="yes"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_to_replace">
								<xsl:value-of select="$param_to_replace"></xsl:value-of>
							</xsl:with-param>
							<xsl:with-param name="param_value">
								<xsl:value-of select="$param_value"></xsl:value-of>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$orig_text = ''">
				<xsl:value-of select="$parsed_text" disable-output-escaping="yes"></xsl:value-of>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>