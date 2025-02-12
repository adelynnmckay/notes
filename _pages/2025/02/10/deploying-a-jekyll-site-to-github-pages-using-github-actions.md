---
title: Deploying a Jekyll Site to GitHub Pages Using GitHub Actions
date: 2025-02-10
tags: 
  - jekyll
categories: 
  - /jekyll
---

This guide explains how to deploy a Jekyll website to GitHub Pages using a GitHub Actions workflow defined in a `.github/workflows/gh-pages.yml`.

See the **Appendix** at the end of this guide for the full contents of this file.

---

## **Prerequisites**
Before setting up GitHub Pages deployment, ensure you have:
- A GitHub repository with your Jekyll site.
- The `gh-pages.yml` workflow file inside `.github/workflows/`.
- GitHub Pages enabled in your repository settings.
- GitHub Pages is set to **GitHub Actions** in the repository settings.

---

## **Understanding the Workflow**
The workflow automates the deployment of your Jekyll site whenever you:
1. Push to the `main` branch.
2. Open a pull request targeting `main`.
3. Manually trigger the workflow via the Actions tab.

### **Workflow Breakdown**
#### **1. Defining the Workflow Name & Triggers**
```yaml
name: Github Pages

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:
```
- The workflow runs when code is pushed or a pull request is created for the `main` branch.
- It can also be triggered manually from the Actions tab.

#### **2. Setting Permissions**
```yaml
permissions:
  contents: write
  pages: write
  id-token: write
```
- Grants necessary permissions to modify repository contents and deploy to GitHub Pages.

#### **3. Managing Concurrent Deployments**
```yaml
concurrency:
  group: "pages"
  cancel-in-progress: false
```
- Ensures that only one deployment runs at a time.
- Ongoing deployments are not canceled to prevent incomplete deployments.

#### **4. Running the Deployment Job**
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
```
- The deployment runs on an Ubuntu-based GitHub-hosted runner.

#### **5. Steps in the Deployment Process**
##### **a. Checkout Repository**
```yaml
    - name: Checkout code
      uses: actions/checkout@v4
```
- Retrieves the latest code from the repository.

##### **b. Set Up Ruby**
```yaml
    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '3.1.6'
        bundler-cache: true
```
- Installs Ruby 3.1.6 and caches gems to speed up subsequent builds.

##### **c. Install Dependencies**
```yaml
    - name: Install dependencies
      run: |
        gem install bundler
        bundle install
```
- Installs Bundler and project dependencies.

##### **d. Build the Jekyll Site**
```yaml
    - name: Build Jekyll site
      run: |
        bundle exec jekyll build
```
- Generates the static site files inside the `_site` directory.

##### **e. Configure GitHub Pages**
```yaml
    - name: Setup GitHub Pages
      uses: actions/configure-pages@v4
```
- Prepares the GitHub Pages environment.

##### **f. Upload Built Site as an Artifact**
```yaml
    - name: Upload artifact for GitHub Pages
      uses: actions/upload-pages-artifact@v2
      with:
        path: ./_site
```
- Uploads the `_site` directory (Jekyll output) as an artifact.

##### **g. Deploy the Site to GitHub Pages**
```yaml
    - name: Deploy to GitHub Pages
      id: deployment
      uses: actions/deploy-pages@v2
```
- Publishes the site on GitHub Pages.

---

## **Enabling GitHub Pages**
After setting up the workflow:
1. Go to **Repository Settings** → **Pages**.
2. Set the source to **GitHub Actions**.
3. Wait for the workflow to complete.

---

## **Manually Running the Workflow**
If needed, you can manually trigger the workflow:
1. Go to the **Actions** tab in your GitHub repository.
2. Select the **GitHub Pages** workflow.
3. Click **Run workflow**.

---

## **Troubleshooting**
- **Site not updating?**
  - Ensure GitHub Pages is set to **GitHub Actions** in the repository settings.
  - Check the Actions tab for errors.

- **Jekyll build failing?**
  - Run `bundle exec jekyll build` locally to check for issues.

---

## **Conclusion**
This GitHub Actions workflow streamlines the deployment of a Jekyll site to GitHub Pages by automatically building and publishing the site whenever you push changes to the `main` branch.

---

## **Appendix**

### `.github/workflows/gh-pages.yml`

```yaml
name: Github Pages

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: write
  pages: write
  id-token: write

# Allow only one concurrent deployment, skipping runs queued between the run in-progress and latest queued.
# However, do NOT cancel in-progress runs as we want to allow these production deployments to complete.
concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: '3.1.6' # Specify the Ruby version to use
        bundler-cache: true # runs 'bundle install' and caches installed gems automatically

    - name: Install dependencies
      run: |
        gem install bundler
        bundle install

    - name: Build Jekyll site
      run: |
        bundle exec jekyll build

    - name: Setup GitHub Pages
      uses: actions/configure-pages@v4

    - name: Upload artifact for GitHub Pages
      uses: actions/upload-pages-artifact@v2
      with:
        path: ./_site

    - name: Deploy to GitHub Pages
      id: deployment
      uses: actions/deploy-pages@v2
```