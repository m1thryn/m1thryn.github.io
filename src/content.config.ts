import { glob } from "astro/loaders";
import { defineCollection } from "astro:content";
import { z } from "zod";

const baseSchema = z.object({
  title: z.string(),
  description: z.string(),
  date: z.coerce.date(),
  updated: z.coerce.date().optional(),
  draft: z.boolean().optional(),
  archive: z.boolean().optional(),
  tags: z.array(z.string()).optional(),
  socials: z.array(z.string()).optional(),
});

const blog = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "./src/content/blog" }),
  schema: baseSchema,
});

const projects = defineCollection({
  loader: glob({ pattern: "**/*.{md,mdx}", base: "./src/content/projects" }),
  schema: baseSchema.extend({
    demoURL: z.string().url().optional(),
    repoURL: z.string().url().optional(),
    packageURL: z.string().url().optional(),
  }),
});

export const collections = { blog, projects };
