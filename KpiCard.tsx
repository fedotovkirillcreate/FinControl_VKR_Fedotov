export function KpiCard({ label, value, tone = 'default' }: { label: string; value: string | number; tone?: 'default' | 'accent' | 'user' | 'danger' }) {
  return (
    <div className={`card kpi ${tone}`}>
      <div className="smallMuted">{label}</div>
      <div className="bigValue">{value}</div>
    </div>
  )
}
