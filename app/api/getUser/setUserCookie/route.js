import { NextResponse } from "next/server";
import { cookies } from 'next/headers'

export async function POST(request){
    try{
        const {user} = await request.json();
        //console.log(user);
        cookies().set('user', user, { secure: true })
        return new NextResponse(JSON.stringify({user}), {
            status: 200,
            headers: {
                'Set-Cookie': cookies().toString()
            }
        });
    }
    catch(error){
        return new NextResponse(JSON.stringify({ error : error.sqlMessage}), { status: 400 });
    }
}
