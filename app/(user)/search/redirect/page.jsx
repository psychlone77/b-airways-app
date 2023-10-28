"use server";
import { useRouter, redirect } from "next/navigation";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";
import Link from "next/link";

export default async function RedirectPage() {
  const session = await getServerSession(authOptions);
  if (session) {
    const response = await fetch(
      `http://localhost:3000/api/getUser?user_id=${session.user.user_id}`
    );
    const data = await response.json();
    console.log(data);
    return (
      <div className="h-[calc(100vh-170px)] flex flex-row justify-center items-center">
        <Link
          className="text-2xl font-nunito bg-primary text-white rounded-md p-5"
          href={{
            pathname: "/booking",
            query: {
              user: JSON.stringify(data),
            },
          }}
        >
          Continue Booking as {data.first_name}
        </Link>
      </div>
    );
    //console.log(data);

    //redirect('/booking');
  } else {
    return (
      <div className="h-[calc(100vh-170px)] flex flex-col justify-center items-center font-nunito gap-4">
        <Link
          className="text-2xl font-nunito bg-primary text-white rounded-md py-5 px-20"
          href="/login"
        >
          Login
        </Link>
        <div>
          Continue as Guest
        </div>
      </div>
    );
  }
}
