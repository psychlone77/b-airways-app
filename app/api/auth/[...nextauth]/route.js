import NextAuth from "next-auth/next";
import CredentialsProvider from "next-auth/providers/credentials";
import { NextResponse } from "next/server";

export const authOptions = {
  session: {
    jwt: true,
    maxAge: 24 * 60 * 60, // 1 day
  },
  providers: [
    CredentialsProvider({
      async authorize(credentials) {
        //console.log(credentials);
        const { email, password, role } = credentials;
        if (role === null) {
          return null;
        }
        if (role === "admin") {
            const query = "SELECT * FROM administrator WHERE admin_name = ?";
            const values = [email];
            const pool = require("../../../../database/db");
            // query database
            const [result] = await pool.execute(query, values);
            const user = result[0];
            console.log(user);
            if (user) {
                // const isValid = await bcrypt.compare(password, user.password);
                // if (isValid) {
                //     return user;
                // }
                if (user.password === password) {
                return user;
                }
            }
            return null;    
        }
        if (role === "user") {
          const query = "SELECT * FROM registered_user WHERE email = ?";
          const values = [email];
          const pool = require("../../../../database/db");
          // query database
          const [result] = await pool.execute(query, values);
          const user = result[0];
          console.log(user);
          if (user) {
            // const isValid = await bcrypt.compare(password, user.password);
            // if (isValid) {
            //     return user;
            // }
            if (user.password === password) {
              return user;
            }
          }
          return null;
        }
      },
    }),
  ],
  secret: "hhhh",
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.user_id = user.user_id;
        token.first_name = user.first_name;
      }
      return token;
    },
    async session({ session, token }) {
      session.user.user_id = token.user_id;
      session.user.first_name = token.first_name;

      return session;
    },
  },
  pages: {
    signIn: "/login",
  },
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
