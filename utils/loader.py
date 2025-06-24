from lxml import etree

def get_texts(lang='fr', xml_path='data/portfolio.xml'):
    tree = etree.parse(xml_path)
    data = {}
    for block in tree.xpath("//block"):
        key = block.get("id")
        content = block.xpath(f"./content[@lang='{lang}']")
        data[key] = content[0].text if content else f"[{key} missing in {lang}]"
    return data
