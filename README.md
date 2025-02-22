# Matthew J. White's Personal Blog

This repository contains the source code for Matthew J. White's personal blog, built using Astro. The blog is hosted on Azure Static Web Apps.

## Project Structure

```text
/
├── .github/
│   ├── dependabot.yml
│   └── workflows/
└── dev-matthewjwhite/
    ├── src/
    │   ├── content/
    │   │   └── blog/
    │   ├── layouts/
    │   └── pages/
    ├── astro.config.mjs
    ├── README.md
    ├── package.json
    └── tsconfig.json
```

## Prerequisites

Before you begin, ensure you have the following installed:

- Node.js v14 or later
- npm v6 or later

## Getting Started

1. **Clone the repository:**
    ```sh
    git clone https://github.com/MattWhite-personal/matthewjwhite.co.uk.git
    cd matthewjwhite.co.uk/dev-matthewjwhite
    ```

2. **Install dependencies:**
    ```sh
    npm install
    ```

3. **Run the development server:**
    ```sh
    npm start
    ```

4. **Build the project for production:**
    ```sh
    npm run build
    ```

5. **Preview the production build:**
    ```sh
    npm run preview
    ```

## Deployment and Maintenance

Github actions deploys the code to an Azure Static Web App which hosts the live website. Dependabot runs on a regular basis to check for updates to key components.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.

## License

This project is licensed under the GPL License - see the LICENSE file for details.

## Contact

For any questions or support, please open an issue.