import "./globals.css";
import type { Metadata } from "next";
import { getServerSession } from "next-auth/next";
import { authOptions } from '../api/auth/[...nextauth]/route';
import Navbar from "@/components/navbar/navbar";
import Footer from "@/components/footer/footer";

export const metadata: Metadata = {
  title: "B Airways",
  description: "Book and reserve tickets",
};

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <div>
        </div>
        <div>{children}</div>
        <div>
          <Footer />
        </div>
      </body>
    </html>
  );
}
