---
title: 'About'
description: 'About ${{values.name}}'
---

<html lang="en">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <meta name="viewport" content="width=device-width" />
    <meta name="generator" content={Astro.generator} />
    <title>{title} - ${{values.name}}</title>
    <meta name="description" content={description} />
  </head>
  <body>
    <main>
      <h1>About ${{values.name}}</h1>
      <p>${{values.description}}</p>
      <p>
        This page provides information about the application and its purpose.
      </p>
      <a href="/">← Back to Home</a>
    </main>
  </body>
</html>

<style>
  main {
    margin: auto;
    padding: 1rem;
    width: 800px;
    max-width: calc(100% - 2rem);
    color: white;
    font-size: 20px;
    line-height: 1.6;
  }
  
  body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    font-family: -apple-system, BlinkMacSystemFont, sans-serif;
  }
  
  h1 {
    font-size: 3rem;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    margin-bottom: 1em;
  }
  
  a {
    color: #fff;
    text-decoration: underline;
  }
  
  a:hover {
    text-decoration: none;
  }
</style>