"use client";
import { signOut, useSession } from "next-auth/react";
import { SessionProvider } from "next-auth/react";
import Link from "next/link";

import LoadingPage from "@/components/loading/loadingPage";
import AdminUnAuthPage from "@/components/admin/unAuth";
import AdminNotAuthPage from "@/components/admin/notAuth";
import AdminNavBar from "@/components/admin/adminNavBar";

function AdminPage() {
  const { data: session, status } = useSession();
  console.log(session);
  if (status === "loading")
    return (
      <div>
        <LoadingPage />
      </div>
    );
  if (status === "unauthenticated") {
    return <div className="mt-44"><AdminUnAuthPage/></div>;
  }
  if (session?.user?.role !== "admin") return <div className="mt-44"><AdminNotAuthPage/></div>;
  if (status === "authenticated" && session?.user?.role === "admin") {
    return (
        <div>
            <AdminNavBar session={session}/>
            Welcome Admin
                        </div>
    );
  }
}

export default function AdminPageWrapper() {
  return (
    <SessionProvider>
      <AdminPage />
    </SessionProvider>
  );
}
