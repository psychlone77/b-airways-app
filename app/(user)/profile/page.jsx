"use client";
import { useSession, SessionProvider } from "next-auth/react";
import { useState, useEffect, use } from "react";

import NavBar from "@/components/navbar/navbar";
import LoadingPage from "@/components/loading/loadingPage";

export default function ProfilePage(props) {
  return (
    <SessionProvider session={props.session}>
      <ProfileContent />
    </SessionProvider>
  );
}

function ProfileContent() {
  const { data: session, status } = useSession();

  const [user, setUser] = useState([]);
  const [contacts, setContacts] = useState([]);
  const [id, setId] = useState(null);

  useEffect(() => {
    if (session && session.user) {
      setId(session.user.user_id);
    }
  }, [session]);

  useEffect(() => {
    const getAll = async () => {
      const responseUser = await fetch(
        `http://localhost:3000/api/getUser?user_id=${id}`
      );
      const user = await responseUser.json();
      const responseContacts = await fetch(
        `http://localhost:3000/api/getUser/contact?user_id=${id}`
      );
      const contacts = await responseContacts.json();
      setUser(user);
      setContacts(contacts);
      console.log(user);
      console.log(contacts);
    };
    if (id) {
      getAll();
    }
  }, [id]);

  //loading
  if (user === undefined || status === "loading") {
    return <LoadingPage />;
  }

  //content
  return (
    <div>
      <div className="flex flex-col items-center p-10">
        <div className={`flex flex-col gap-2 w-fit p-5 rounded-md border border-primary shadow-md shadow-secondary ${user.registered_user_category === 'Gold' ? 'bg-gradient-to-br from-yellow-400 via-yellow-200 to-yellow-400' : user.registered_user_category === 'Frequent' ? 'bg-gradient-to-br from-purple-400 via-purple-200 to-purple-400' : 'bg-white'}`}>
          <h1 className="text-4xl text-primary font-nunito font-thin"> Hello {user.first_name} {user.last_name}</h1>
          <h2 className="text-xl text-gray-500 font-nunito font-thin"> {user.gender}</h2>
          <h2 className="text-xl text-gray-500 font-nunito font-thin"> Birthday : {new Date(user.birth_date).toLocaleDateString('en-GB')}</h2>
          <h2 className="text-xl text-gray-500 font-nunito font-thin"> {user.email}</h2>
          <h2 className="text-xl text-gray-500 font-nunito font-thin"> Passport No. : {user.passport_no}</h2>
          <h2 className="text-xl text-gray-500 font-nunito font-thin"> Membership Level : {user.registered_user_category}</h2>
          <h2 className="text-xl text-gray-500 font-nunito font-thin"> Member Since : {new Date(user.joined_datetime).toLocaleDateString('en-GB')}</h2>
        </div>
      </div>
    </div>
  )
}
