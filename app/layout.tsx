import "./globals.css";
import type { Metadata } from "next";
import Navbar from "@/components/navbar/navbar";
import Footer from "@/components/footer/footer";

export const metadata: Metadata = {
  title: "B Airways",
  description: "Book and reserve tickets",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        {/* <div>
          <Navbar />
        </div> */}
        <div>{children}</div>
        <div>
          <Footer />
        </div>
      </body>
    </html>
  );
}
