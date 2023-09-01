import { Html, Head, Main, NextScript } from "next/document";

import { ThemeScope } from "@greenlabs/formula-components";

export default function Document() {
  return (
    <ThemeScope
      brand="basic"
      themeName="light"
      render={({ className }) => (
        <Html className={className} lang="ko">
          <Head />
          <body>
            <Main />
            <NextScript />
          </body>
        </Html>
      )}
    />
  );
}
