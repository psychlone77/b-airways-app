import Link from 'next/link'

export default function AdminUnAuthPage() {
    return(
        <div className='flex items-center justify-center w-full h-[calc(100vh-77px)]'>
            <div className='flex flex-col gap-5 justify-center items-center bg-black rounded-lg p-10 text-white font-nunito'>
                <h1 className='text-5xl font-bold'>Unauthorized</h1>
                <Link href="/admin/login">
                    <div className='font-extralight text-gray-400'>If your an Admin Click Here</div>
                </Link>
            </div>
        </div>
    )
}