import { signOut } from "next-auth/react";

export default function AdminNavBar() {
  return (
    <div>
      <div className="flex flex-row p-5 justify-between">
        <h1 className="font-museo text-3xl">B AIRWAYS</h1>
        <button
          className="bg-black rounded-3xl text-white py-2 px-5 font-nunito shadow-sm shadow-gray-400 hover:shadow-lg hover:shadow-gray-400 transition duration-300 ease-in-out"
          onClick={() =>
            signOut({
              callbackUrl: "http://localhost:3000/admin/login",
            })}
        >
          {" "}
          Sign Out{" "}
        </button>
      </div>
    </div>
  );
}
