import { SITE } from "@/consts";
import { shouldRenderPage } from "@/lib/utils";
import rss from "@astrojs/rss";
import { getCollection } from "astro:content";

export async function GET(context) {
  const blog = (await getCollection("blog")).filter(
    (p) => shouldRenderPage(p) && !p.data.archive,
  );
  const projects = (await getCollection("projects")).filter(
    (p) => shouldRenderPage(p) && !p.data.archive,
  );

  const items = [...blog, ...projects].sort(
    (a, b) => new Date(b.data.date).valueOf() - new Date(a.data.date).valueOf(),
  );

  return rss({
    title: SITE.TITLE,
    description: SITE.DESCRIPTION,
    site: context.site,
    stylesheet: "/rss-styles.xsl",
    items: items.map((item) => ({
      title: item.data.title,
      description: item.data.description,
      pubDate: item.data.date,
      link: `/${item.collection}/${item.id}/`,
      customData: `<updated>
        ${item.data.updated !== undefined ? item.data.updated.toISOString() : ""}
      </updated>`,
    })),
  });
}
