<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Force the output to be strict XHTML -->
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"></xsl:output>
	<xsl:param name="class_id"></xsl:param>
	<xsl:param name="image_server_url">http://img.preview.webmd.com/dtmcms/preview</xsl:param>
	<xsl:param name="moduletitle"></xsl:param>
	<xsl:param name="site_id">3</xsl:param>
	<xsl:param name="domain">devint.webmdtest.net</xsl:param>
	<xsl:template match="/">
		<xsl:apply-templates select="webmd_rendition/content/wbmd_asset/webmd_module/module_data"></xsl:apply-templates>
	</xsl:template>
	<xsl:template match="/webmd_rendition/content/wbmd_asset/webmd_module/module_data">
		<!--Begin Latest Headline module -->
		
		<div class="promo_panel_container">									
		<div class="promo_ss">
		<div class="preload_spinner"><![CDATA[ ]]></div>
		
			<div class="ss">
				<div class="slide">
					<div class="promo_panel">
						<h2>Health News</h2>
						<div class="panel_items">
						<xsl:apply-templates select="//assetinfo_coll/assetinfo[position() &lt;= 3]" mode="Image"></xsl:apply-templates>
						</div>
					</div>
				</div>
				<div class="slide">
					<div class="promo_panel">
						<h2>Health News</h2>
						<div class="panel_items">
						<xsl:apply-templates select="//assetinfo_coll/assetinfo[position() &gt;= 4 and position() &lt;= 6]" mode="Image"></xsl:apply-templates>
						</div>
					</div>
				</div>
				<div class="slide">
					<div class="promo_panel">
						<h2>Health News</h2>
						<div class="panel_items">
						<xsl:apply-templates select="//assetinfo_coll/assetinfo[position() &gt;= 7 and position() &lt;= 9]" mode="Image"></xsl:apply-templates>
						</div>
					</div>
				</div>
            </div>
		
		<div class="nav"><a class="ss_nav_prev" href=""><span class="arrow_left"></span></a><div class="ss_nav"><span class="bullet"></span><span class="bullet"></span><span class="bullet"></span></div><a class="ss_nav_next" href=""><span class="arrow_right"></span></a></div>
		
		</div>

	<div class="bottom"><![CDATA[ ]]></div>
</div>
        
        

	</xsl:template>
	
	
	
	<xsl:template match="//assetinfo_coll/assetinfo" mode="Image">
		<!-- editorial module -->
		<xsl:variable name="furl">
			<xsl:call-template name="GetURLAsset">
				<xsl:with-param name="urlID">
					<xsl:value-of select="friendly_url"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="thumbFurl">
			<xsl:call-template name="GetURLImage">
				<xsl:with-param name="imageUrlID">
					<xsl:value-of select="thumbnail_url"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="DefaultThumbnail_url">
			<xsl:value-of select="$image_server_url"></xsl:value-of>/webmd/consumer_assets/site_images/articles/thumbnails_daily_images/default.jpg
		</xsl:variable>
		
		
		<div class="item">
			
			<div class="panel_image">
			<xsl:choose>
				<xsl:when test="$furl !=''">
					<a href="{$furl}">
						<xsl:attribute name="onclick">return sl(this,'','prm-nws_<xsl:value-of select="position()+1"></xsl:value-of>-img');</xsl:attribute>
						<xsl:choose>
							<xsl:when test="$thumbFurl !='' and (contains($thumbFurl,'.gif') or contains($thumbFurl,'.jpg') or contains($thumbFurl,'.png'))">
								<span class="image_source" src="{$thumbFurl}" alt="{link_text}" style="width:69px; height:75px; display:block; -webkit-box-shadow: inset 0 0 1px #888;" />
							</xsl:when>
							<xsl:otherwise>
								<span class="image_source" src="{$DefaultThumbnail_url}" alt="{link_text}" style="width:69px; height:75px; display:block; -webkit-box-shadow: inset 0 0 1px #888;" />
							</xsl:otherwise>
						</xsl:choose>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$thumbFurl !='' and (contains($thumbFurl,'.gif') or contains($thumbFurl,'.jpg') or contains($thumbFurl,'.png'))">
							<span class="image_source" src="{thumbnail_url}" alt="{link_text}" style="width:69px; height:75px; display:block; -webkit-box-shadow: inset 0 0 1px #888;" />
						</xsl:when>
						<xsl:otherwise>
							<span class="image_source" src="{$DefaultThumbnail_url}" alt="{link_text}" style="width:69px; height:75px; display:block; -webkit-box-shadow: inset 0 0 1px #888;" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			</div>
			
			<div class="panel_text">
				<h3>
				<xsl:choose>
					<xsl:when test="$furl !=''">
						<a class="text_link" href="{$furl}">
							<xsl:attribute name="onclick">return sl(this,'','prm-nws_<xsl:value-of select="position()+1"></xsl:value-of>');</xsl:attribute>
							<xsl:value-of select="title"></xsl:value-of>
						</a>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="title"></xsl:value-of>
					</xsl:otherwise>
				</xsl:choose>
				</h3>
				
				<p>
					<xsl:value-of select="substring(description, 1, 50)"></xsl:value-of><xsl:text>...</xsl:text>
				</p>
            </div>
           
            <div class="clearing"><![CDATA[ ]]></div>
	</div>
		
		
		<!-- end editorial module -->
	</xsl:template>
	
	
	
	<xsl:template name="GetLinkIconType">
		<xsl:param name="link_href"></xsl:param>
		<xsl:choose>
			<xsl:when test="contains(string($link_href),'blogs.') or contains(string($link_href),'boards.')">
				<xsl:text>type_com_old</xsl:text>
			</xsl:when>
			<xsl:when test="contains(string($link_href),'/video/') or contains(string($link_href),'-tv')">
				<xsl:text>type_vid_old</xsl:text>
			</xsl:when>
			<xsl:when test="contains(string($link_href),'slideshow')">
				<xsl:text>type_ss_old</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="GetURLRef">
		<xsl:param name="ObjectID"></xsl:param>
		<xsl:if test="(//referenced_objects/object[@chronic_id=$ObjectID and @pointer='0']/target[@siteid=$site_id]/@friendlyurl) or (//referenced_objects/object[@chronic_id=$ObjectID and @pointer='1']/target/@friendlyurl)">
			<xsl:choose>
				<xsl:when test="//referenced_objects/object[@chronic_id=$ObjectID]//@pointer = '1'">
					<xsl:value-of select="//referenced_objects/object[@chronic_id=$ObjectID][1]/target/@friendlyurl"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>http://<xsl:value-of select="//referenced_objects/object[@chronic_id=$ObjectID][1]/target[@siteid=$site_id]/@prefix[1]"></xsl:value-of>.<xsl:value-of select="$domain"></xsl:value-of>
					<xsl:value-of select="//referenced_objects/object[@chronic_id=$ObjectID][1]/target[@siteid=$site_id]/@friendlyurl[1]"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetURLAsset">
		<xsl:param name="http">http://</xsl:param>
		<xsl:param name="urlID"></xsl:param>
		<xsl:if test="$urlID != ''">
			<!-- Concatenate Prefix Domain and FrendlyURL -->
			<xsl:value-of select="$http"></xsl:value-of>
			<xsl:value-of select="prefix"></xsl:value-of>.<xsl:value-of select="$domain"></xsl:value-of>
			<xsl:value-of select="$urlID"></xsl:value-of>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetURLImage">
		<xsl:param name="http">http://</xsl:param>
		<xsl:param name="imageUrlID"></xsl:param>
		<xsl:if test="$imageUrlID != ''">
			<!-- Concatenate Prefix Domain and FrendlyURL -->
			<xsl:value-of select="$image_server_url"></xsl:value-of>
			<xsl:choose>
				<xsl:when test="starts-with(string($imageUrlID),'/webmd/webmd/')">
					<xsl:value-of select="substring-after(string($imageUrlID), '/webmd')"></xsl:value-of>
				</xsl:when>
				<xsl:when test="starts-with(string($imageUrlID),'webmd/webmd/')">
					<xsl:value-of select="substring-after(string($imageUrlID), 'webmd')"></xsl:value-of>
				</xsl:when>
				<xsl:when test="starts-with(string($imageUrlID),'webmd')">
					<xsl:text>/</xsl:text>
					<xsl:value-of select="$imageUrlID"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$imageUrlID"></xsl:value-of>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="GetAltTextRef">
		<xsl:param name="ObjectID"></xsl:param>
		<xsl:value-of select="/webmd_rendition/referenced_objects/object[@chronic_id=$ObjectID]/target[@name=$site_id]/@alt_text"></xsl:value-of>
	</xsl:template>
</xsl:stylesheet>

