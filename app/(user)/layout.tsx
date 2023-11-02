import "./globals.css";
import type { Metadata } from "next";
import { getServerSession } from "next-auth/next";
import { authOptions } from '../api/auth/[...nextauth]/route';
import Navbar from "@/components/navbar/navbar";
import Footer from "@/components/footer/footer";

export const metadata: Metadata = {
  title: "B Airways",
  description: "Book and reserve tickets",
  icons:{icon: "/flight.png"}
};

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const data = await getServerSession(authOptions);
  console.log(data)
  return (
    <html lang="en">
      <body>
        <div className="flex flex-grow flex-col min-h-screen">
          {data && data.user && data.user.role === 'admin' ? (
            <div className="flex flex-grow flex-col min-h-screen">
              <div className="mt-[70px] mb-auto h-full font-nunito flex flex-col justify-center items-center">
                <div className="">You are currently logged in as an Admin</div>
              </div>
              <div>
                <Footer />
              </div>
            </div>
          ) : (
            <>
              <div className="fixed top-0 left-0 right-0">
                <Navbar session={data} />
              </div>
              <div className="mt-[70px] mb-auto">
                {children}
              </div>
              <div>
                <Footer />
              </div>
            </>
          )}
        </div>
      </body>
    </html>
  );
}
