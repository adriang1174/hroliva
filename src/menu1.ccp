<Page id="1" templateExtension="html" relativePath="." fullRelativePath="." secured="False" urlType="Relative" isIncluded="True" SSLAccess="False" isService="False" cachingEnabled="False" cachingDuration="1 minutes" wizardTheme="Simple" wizardThemeVersion="3.0" needGeneration="0">
	<Components>
		<Menu id="2" secured="False" sourceType="Table" returnValueType="Number" connection="Connection1" name="Menu1" menuType="Horizontal" dataSource="menu_cat" idField="idCat" parentIdField="idParentCat" menuSourceType="DataSource" PathID="menu1Menu1">
			<Components>
				<Link id="3" visible="Yes" fieldSourceType="DBColumn" dataType="Text" html="False" hrefType="Database" urlType="Relative" preserveParameters="GET" name="ItemLink" hrefSource="ubicacion" fieldSource="descripcion" PathID="menu1Menu1ItemLink">
					<Components/>
					<Events/>
					<LinkParameters/>
					<Attributes/>
					<Features/>
				</Link>
			</Components>
			<Events/>
			<TableParameters/>
			<JoinTables/>
			<JoinLinks/>
			<Fields/>
			<SPParameters/>
			<SQLParameters/>
			<SecurityGroups/>
			<Attributes>
				<Attribute id="4" name="Target" sourceType="Expression" source="&quot;&quot;"/>
			</Attributes>
			<MenuItems/>
			<Features/>
		</Menu>
	</Components>
	<CodeFiles>
		<CodeFile id="Code" language="PHPTemplates" name="menu1.php" forShow="True" url="menu1.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="menu1.asp" forShow="True" url="menu1.asp" comment="'" codePage="windows-1252"/>
</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
