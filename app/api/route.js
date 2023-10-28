import { getServerSession } from "next-auth";
import { authOptions } from "./auth/[...nextauth]/route";
import { NextResponse } from "next/server";

export async function GET(request) {
    const session = await getServerSession({ req: request, ...authOptions });
    if(session){
        console.log("get api",session);
    return NextResponse.json({authenticated: !!session.user})
    }
    else{
        return NextResponse.json({authenticated: false})
    }
}
