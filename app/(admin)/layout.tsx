import "./globals.css";
import type { Metadata } from "next";
import { getServerSession } from "next-auth/next";
import { authOptions } from "../api/auth/[...nextauth]/route";
import Navbar from "@/components/navbar/navbar";
import Footer from "@/components/footer/footer";

export const metadata: Metadata = {
  title: "Admin Dashboard",
  description: "Admin Function",
  icons:{icon: "/shield_person.png"}
};

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <div className="flex flex-col flex-grow min-h-screen">
          <div className="mb-auto">{children}</div>
          <div>
            <Footer />
          </div>
        </div>
      </body>
    </html>
  );
}
