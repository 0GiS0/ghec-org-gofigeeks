---
title: '${{values.name}}'
description: '${{values.description}}'
---

<html lang="en">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <meta name="viewport" content="width=device-width" />
    <meta name="generator" content={Astro.generator} />
    <title>{title}</title>
    <meta name="description" content={description} />
  </head>
  <body>
    <main>
      <h1>Welcome to {title}</h1>
      <p>{description}</p>
      <p>
        This is an Astro frontend application. Get started by editing the pages in <code>src/pages/</code>.
      </p>
      <ul>
        <li><a href="/about">About</a></li>
        <li><a href="/api/health">Health Check</a></li>
      </ul>
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
    font-size: 4rem;
    font-weight: 700;
    line-height: 1;
    text-align: center;
    margin-bottom: 1em;
  }
  
  code {
    font-family: Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono,
      Bitstream Vera Sans Mono, Courier New, monospace;
    background: rgba(255, 255, 255, 0.1);
    padding: 0.2em 0.4em;
    border-radius: 0.2em;
  }
  
  ul {
    list-style: none;
    padding: 0;
  }
  
  li {
    margin: 0.5em 0;
  }
  
  a {
    color: #fff;
    text-decoration: underline;
  }
  
  a:hover {
    text-decoration: none;
  }
</style>