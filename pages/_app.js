import "../src/styles/global.css";
import "@greenlabs/formula-components/formula.css";
import Layout from "../src/components/Layout.mjs";

function MyApp({ Component, pageProps }) {
  return (
    <Layout>
      <Component {...pageProps} />
    </Layout>
  );
}

export default MyApp;
