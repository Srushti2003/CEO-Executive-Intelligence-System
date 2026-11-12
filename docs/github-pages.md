# Publish the portfolio on GitHub Pages

The portfolio is a static site. GitHub Pages serves the root `index.html`, the stylesheet and script in `portfolio-assets/`, and the original report images in `power bi/screenshots/`. No install or build command is required.

1. Review and merge the portfolio pull request into `main` of the original repository.
2. Open the repository’s **Settings → Pages**. A repository admin can configure the publishing source.
3. Under **Build and deployment**, choose **Deploy from a branch**. Select **main** and **/ (root)**, then choose **Save**.
4. When deployment succeeds, open the URL shown in Pages settings and check all five report pages. Use **Enlarge image** to verify the original screenshots also load at full resolution.

The project site normally uses `https://srushti2003.github.io/CEO-Executive-Intelligence-System/` unless the repository has a custom domain. See [GitHub’s publishing source guide](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).

## Preview locally

From the repository root, run `python -m http.server 8000` and open `http://localhost:8000/`. Keep the original filenames intact. The gallery tries local WebP previews, local JPEG originals and canonical upstream copies in that order. The enlarged viewer opens the original JPEG.
