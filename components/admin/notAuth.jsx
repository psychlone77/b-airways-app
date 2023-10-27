import Link from 'next/link'
import { signOut } from 'next-auth/react'

export default function AdminNotAuthPage() {
    const handleClick = () => {
        signOut({callbackUrl: 'http://localhost:3000/admin/login'})
    }
    return(
        <div className='flex items-center justify-center w-full h-[calc(100vh-77px)]'>
            <div className='flex flex-col gap-5 justify-center items-center bg-black rounded-lg p-10 text-white font-nunito'>
                <h1 className='text-5xl font-bold'>Access Denied</h1>
                    <button onClick={handleClick} className='font-extralight text-gray-400'>If your an Admin Click Here</button>
            </div>
        </div>
    )
}